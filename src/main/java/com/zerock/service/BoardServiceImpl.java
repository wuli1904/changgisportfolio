package com.zerock.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zerock.domain.BoardVO;
import com.zerock.domain.CommentVO;
import com.zerock.domain.Criteria;
import com.zerock.domain.MemberVO;
import com.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("register........" + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get..........."+bno);
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify........."+board);
		return mapper.update(board) ==1;
	}
	
	@Override
	public boolean remove(Long bno) {
		log.info("remove........."+bno);
		mapper.cbdel(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	@Override
	public MemberVO viewMember(String idinfo) {
		return mapper.viewMember(idinfo);
	}

	@Override
	public boolean loginCheck(MemberVO member, HttpSession session) {
		String result = mapper.loginCheck(member);

		if(result != null) {
			
			return true;
		}else {
			return false;
		}
	}

	@Override
	public void lregister(MemberVO member) {
		mapper.minsert(member);
	}

	@Override
	public int idChk(MemberVO member) {
		int result = mapper.idChek(member);
		return result;
	}

	@Override
	public List<CommentVO> readComment(Long bno) {
		return mapper.cSelect(bno);
	}

	@Override
	public boolean cDelete(Long cno) {
		// TODO Auto-generated method stub
		return mapper.cdel(cno) == 1;
	}

	@Override
	public void cInsert(CommentVO comment) {
		mapper.cInsert(comment);
		
	}

	@Override
	public boolean passwdCheck(BoardVO board) {
		int result = mapper.passwdChk(board.getBno(),board.getPasswd());
		if(result == 1) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with criteria"+ cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
}
