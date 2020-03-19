package com.douzone.jblog.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.douzone.jblog.service.BlogService;
import com.douzone.jblog.service.FileUploadService;
import com.douzone.jblog.vo.BlogVo;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.PostVo;
import com.douzone.jblog.vo.UserVo;
import com.douzone.security.AuthUser;

@Controller
@RequestMapping("/{id:(?!assets).*}")
public class BlogController {

	@Autowired
	private BlogService blogService;
	@Autowired
	private FileUploadService fileUploadService;

	public void blogVo(Model model, String id) {
		BlogVo vo = blogService.getBlogMain(id);
		model.addAttribute("blogVo", vo);
	}

	@RequestMapping({ "", "/{pathNo1}", "/{pathNo1}/{pathNo2}" })
	public String index(Model model,
			@PathVariable String id, 
			@AuthUser UserVo authUser, 
			@PathVariable Optional<Long> pathNo1,
			@PathVariable Optional<Long> pathNo2, 
			ModelMap modelMap) {

		blogVo(model, id);
		List<CategoryVo> list = blogService.getBlogCategory(id);
		model.addAttribute("list", list);

		Long categoryNo = 0L;
		Long postNo = 0L;
		
		if (pathNo2.isPresent()) {
			postNo = pathNo2.get();
			categoryNo = pathNo1.get();
		} else if (pathNo1.isPresent()) {
			categoryNo = pathNo1.get();
		}

		modelMap.putAll(blogService.getAll(id, categoryNo, postNo));
		
		return "blog/blog-main";
	}

	@RequestMapping(value = "/admin/basic")
	public String blogBasic(Model model, @AuthUser UserVo authUser, @PathVariable("id") String id) {
		if (authUser == null || !id.equals(authUser.getId())) {
			return "redirect:/user/login";
		}
		blogVo(model, id);
		return "blog/blog-admin-basic";
	}

	@RequestMapping(value = "/admin/update", method = RequestMethod.POST)
	public String update(@ModelAttribute BlogVo blogVo, @AuthUser UserVo authUser,
			@RequestParam(value = "file") MultipartFile multipartFile, @PathVariable("id") String id) {
		String url = fileUploadService.restore(multipartFile);
		if (url.equals("")) {
			BlogVo vo = blogService.getBlogMain(id);
			blogVo.setLogo(vo.getLogo());
		} else {
			blogVo.setLogo(url);
		}
		blogService.update(blogVo);

		return "redirect:/{id}";
	}

	@RequestMapping(value = "/admin/category")
	public String blogCategory(Model model, @AuthUser UserVo authUser, @PathVariable("id") String id) {

		blogVo(model, id);

		List<CategoryVo> list = blogService.getBlogCategory(id);
		model.addAttribute("list", list);
		return "blog/blog-admin-category";
	}

	@RequestMapping(value = "/admin/write")
	public String blogWrite(Model model, @AuthUser UserVo authUser, @PathVariable("id") String id) {
		blogVo(model, id);
		List<CategoryVo> list = blogService.getBlogCategory(id);
		model.addAttribute("list", list);
		return "blog/blog-admin-write";
	}

	@RequestMapping(value = "/admin/write", method = RequestMethod.POST)
	public String blogWrite(@ModelAttribute PostVo postVo, @RequestParam(value = "category", required = true) Long no) {
		postVo.setCategoryNo(no);
		blogService.insertPost(postVo);
		return "redirect:/{id}";
	}

	@RequestMapping(value = "/admin/category", method = RequestMethod.POST)
	public String blogCategory(@ModelAttribute CategoryVo categoryVo, @PathVariable("id") String id) {
		CategoryVo vo = categoryVo;
		vo.setId(id);
		blogService.insertCategory(vo);
		return "redirect:/{id}/admin/category";
	}

	@RequestMapping("/admin/category/delete/{categoryNo}")
	public String blogCategoryDelete(@PathVariable("categoryNo") Long no) {
		blogService.deleteCategory(no);
		return "redirect:/{id}/admin/category";
	}
	
}
