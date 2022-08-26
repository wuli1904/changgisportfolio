package com.zerock.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.zerock.domain.BoardVO;
import com.zerock.domain.CommentVO;
import com.zerock.domain.Criteria;
import com.zerock.domain.MemberVO;

public interface BoardService {
	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getList(Criteria cri);
	
	public boolean loginCheck(MemberVO member,HttpSession session);
	
	public MemberVO viewMember(String idinfo);
	
	public void logout(HttpSession session);
	//id register
	public void lregister(MemberVO member);
	
	public int idChk(MemberVO member);
	
	public List<CommentVO> readComment(Long bno);
	
	public boolean cDelete(Long cno);
	
	public void cInsert(CommentVO comment);
	
	public boolean passwdCheck(BoardVO board);
	
	public int getTotal(Criteria cri);
}
