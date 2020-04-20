package com.douzone.jblog.controller.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.douzone.jblog.dto.JsonResult;
import com.douzone.jblog.service.BlogService;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.UserVo;
import com.douzone.security.AuthUser;

@RestController("BlogApiController")
@RequestMapping("/{id:(?!assets).*}")
public class BlogController {
	
	@Autowired
	private BlogService blogService;

	@PostMapping("/admin/category")
	public JsonResult insertCategory(
			@RequestBody CategoryVo vo,
			@PathVariable("id") String id) {
		vo.setId(id);
		blogService.insertCategory(vo);
		CategoryVo category = blogService.selectRecentlyCategory(vo);
		category.setCountCategory(blogService.countCategory(vo));
		return JsonResult.success(category);
	}
	
	@GetMapping("/admin/category/list")
	public JsonResult list(
			@AuthUser UserVo authUser,
			@PathVariable("id") String id) {
		List<CategoryVo> list = blogService.getBlogCategory(id);
		return JsonResult.success(list);
	}
	
	@DeleteMapping("/admin/category/delete/{no}")
	public JsonResult delete(
			@PathVariable("no") Long no) {
		blogService.deleteCategory(no);
		return JsonResult.success(no);
	}
	
}
