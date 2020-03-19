package com.douzone.jblog.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.douzone.jblog.repository.BlogRepository;
import com.douzone.jblog.vo.BlogVo;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.PostVo;
import com.douzone.jblog.vo.UserVo;

@Service
public class BlogService {

	@Autowired
	private BlogRepository blogRepository;	
	
	public int create(UserVo vo) {
		BlogVo blogVo = new BlogVo();
		blogVo.setId(vo.getId());
		blogVo.setTitle(vo.getName() + "님의 블로그");
		blogVo.setLogo("/assets/images/spring-logo.jpg");
		return blogRepository.create(blogVo);
	}

	public Map<String, Object> getAll(String id, Long categoryNo, Long postNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(categoryNo != 0L && postNo != 0L) {
			HashMap<String, Object> setMap = new HashMap<String, Object>();
			setMap.put("id", id);
			setMap.put("categoryNo", categoryNo);
			setMap.put("postNo", postNo);
			PostVo mainPost =  blogRepository.getCategoryPost(setMap);
			List<PostVo> postList = blogRepository.getCategoryPostList(setMap);

			map.put("mainPost", mainPost);
			map.put("postList", postList);
		} else if (categoryNo != 0L && postNo == 0L) {
			HashMap<String, Object> setMap = new HashMap<String, Object>();
			setMap.put("id", id);
			setMap.put("categoryNo", categoryNo);
			PostVo mainPost = blogRepository.getCategoryMainPost(setMap);
			List<PostVo> postList = blogRepository.getCategoryPostList(setMap);
			
			map.put("mainPost", mainPost);
			map.put("postList", postList);
		} else {
			UserVo vo = new UserVo();
			vo.setId(id);
			PostVo mainPost = blogRepository.getBlogMainPost(vo);
			List<PostVo> postList = blogRepository.getBlogMainPostList(vo);
			
			map.put("mainPost", mainPost);
			map.put("postList", postList);
		}
		return map;
	}
	
	public BlogVo getBlogMain(String id) {
		UserVo vo = new UserVo();
		vo.setId(id);
		return blogRepository.getBlogMain(vo);
	}
	
	public List<CategoryVo> getBlogCategory(String id) {
		UserVo vo = new UserVo();
		vo.setId(id);
		return blogRepository.getBlogCategory(vo);
	}

	public void update(BlogVo blogVo) {
		blogRepository.update(blogVo);
	}
	
	public int insertCategory(CategoryVo categoryVo) {
		return blogRepository.insertCategory(categoryVo);
	}

	public int deleteCategory(Long no) {
		return blogRepository.deleteCategory(no);
	}

	public void insertPost(PostVo postVo) {
		blogRepository.insertPost(postVo);
	}
	









}
