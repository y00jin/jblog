package com.douzone.jblog.service;

import java.util.HashMap;
import java.util.List;

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
	
	public PostVo getBlogMainPost(String id) {
		UserVo vo = new UserVo();
		vo.setId(id);
		return blogRepository.getBlogMainPost(vo);
	}

	public List<PostVo> getBlogMainPostList(String id) {
		UserVo vo = new UserVo();
		vo.setId(id);
		return blogRepository.getBlogMainPostList(vo);
	}

	public PostVo getCategoryMainPost(String id, Long categoryNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("categoryNo", categoryNo);
		return blogRepository.getCategoryMainPost(map);
	}

	public List<PostVo> getCategoryPostList(String id, Long categoryNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("categoryNo", categoryNo);
		return blogRepository.getCategoryPostList(map);
	}
	
	public PostVo getCategoryPost(String id, Long categoryNo, Long postNo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("categoryNo", categoryNo);
		map.put("postNo", postNo);
		return blogRepository.getCategoryPost(map);
	}
}
