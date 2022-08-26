package com.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zerock.domain.BoardVO;
import com.zerock.domain.CommentVO;
import com.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("가나다");
		board.setContent("aaa");
		board.setWriter("user001");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	public void testRead() {
		BoardVO board = mapper.read(1L);
		log.info(board);
	}
	
	public void testDelete() {
		log.info("DELTE COUNT:" + mapper.delete(3L));
	}
	
	public void testUpdate() {
		BoardVO board = new BoardVO();
		
		board.setBno(5L);
		board.setTitle("수정된제목");
		board.setContent("수정된 내용");
		board.setWriter("user00");
		
		int count = mapper.update(board);
		log.info("UPDATE COUNT: "+count);
	}
	
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("테스");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
}
