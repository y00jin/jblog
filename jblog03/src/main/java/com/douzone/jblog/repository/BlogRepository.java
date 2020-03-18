package com.douzone.jblog.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.douzone.jblog.vo.BlogVo;
import com.douzone.jblog.vo.CategoryVo;
import com.douzone.jblog.vo.PostVo;
import com.douzone.jblog.vo.UserVo;

@Repository
public class BlogRepository {

	@Autowired
	private SqlSession sqlSession;
	
	public int create(BlogVo vo) {
		sqlSession.insert("blog.create", vo);
		return sqlSession.insert("blog.defaultcategory",vo);
	}

	public BlogVo getBlogMain(UserVo vo) {
		BlogVo blogVo = sqlSession.selectOne("blog.getblogmain", vo);
		return blogVo;
	}
	
	public List<CategoryVo> getBlogCategory(UserVo vo) {
		List<CategoryVo> categoryVo = sqlSession.selectList("blog.getblogcategory", vo);
		return categoryVo;
	}

	public void update(BlogVo blogVo) {
		sqlSession.update("blog.update", blogVo);
	}

	public int insertCategory(CategoryVo vo) {
		return sqlSession.insert("blog.insertcategory", vo);
	}

	public int deleteCategory(Long no) {
		return sqlSession.delete("blog.deletecategory", no);
	}

	public void insertPost(PostVo postVo) {
		sqlSession.insert("blog.insertpost", postVo);
	}
	
	public PostVo getBlogMainPost(UserVo vo) {
		return sqlSession.selectOne("blog.getblogmainpost", vo);
	}
	
	public List<PostVo> getBlogMainPostList(UserVo vo) {
		return sqlSession.selectList("blog.getblogmainpostlist", vo);
	}
	
	public PostVo getCategoryMainPost(HashMap map) {
		return sqlSession.selectOne("blog.getcategorymainpost", map);
	}

	public List<PostVo> getCategoryPostList(HashMap map) {
		return sqlSession.selectList("blog.getcategorypostlist", map);
	}

	public PostVo getCategoryPost(HashMap map) {
		return sqlSession.selectOne("blog.getcategorypost", map);
	}
}
