package com.zerock.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zerock.domain.BoardVO;
import com.zerock.domain.CommentVO;
import com.zerock.domain.Criteria;
import com.zerock.domain.MemberVO;
import com.zerock.domain.PageDTO;
import com.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	//board list page
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list"+cri);
		model.addAttribute("list",service.getList(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	//board insert page
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr, HttpServletResponse res) throws IOException{
		try {
		log.info("register:"+board);
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/board/list";
		}catch(Exception e) {
			res.setContentType("text/html; charset=euc-kr");
			PrintWriter out = res.getWriter();
			out.println("<script>alert(\"에러 : 입력한 정보란을 확인해주세요!\"); location.href='/board/register'</script>");
			out.flush();
			return "";
		}
	}
	@GetMapping("/register")
	public void register() {
		
	}
	//board read page
	@RequestMapping(value = {"/get"}, method = RequestMethod.GET)
	public String get(@RequestParam("bno") Long bno, Model model) throws Exception {
		log.info("/get");
		model.addAttribute("commentList",service.readComment(bno));
		model.addAttribute("board",service.get(bno));
		
		return "board/get";
	}
	//board update page
	@GetMapping("/modify")
	public void modify(@RequestParam("bno") Long bno, Model model) throws Exception {
		log.info("/modify");
		model.addAttribute("board",service.get(bno));
	}
	@PostMapping("/modify")
	public String modify(@RequestParam("bno") Long bno, BoardVO board, RedirectAttributes rttr) {
		try {
		log.info("modify: "+board);
		if(service.passwdCheck(board)==true) {
			service.modify(board);
			return "redirect:/board/list";
		}else {
			rttr.addFlashAttribute("result","fail");
			return "redirect:/board/modify?bno="+board.getBno();
		}
		}catch(Exception e) {
			rttr.addFlashAttribute("result","nfail");
			return "redirect:/board/modify?bno="+board.getBno();
		}
	}
	//board delete
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,BoardVO board,RedirectAttributes rttr) {
		log.info("remove...."+board.getBno()+board.getPasswd());
		if(service.passwdCheck(board)==true) {
			service.remove(bno);
			rttr.addFlashAttribute("result","sucess");
			return "redirect:/board/list";
		}else {
			rttr.addFlashAttribute("result","fail");
			return "redirect:/board/modify?bno="+board.getBno();
		}
		
	}
	//member insert page
	@ResponseBody
	@PostMapping("/lregister")
	public String minsert(MemberVO member, RedirectAttributes rttr, HttpServletResponse res) throws IOException {
		try {
		int result= service.idChk(member);
		if(member.getPasswd().equals(member.getPasswdc()) && result == 0) {
		log.info("lregister:"+member);
		service.lregister(member);
		rttr.addFlashAttribute("result",member.getUno());
		res.setContentType("text/html; charset=euc-kr");
		PrintWriter out = res.getWriter();
		out.println("<script>alert(\"가입이 완료되었습니다. 로그인해주세요.\"); location.href='/board/list'</script>");
		out.flush();
		return "";
		}else {
		res.setContentType("text/html; charset=euc-kr");
		PrintWriter out = res.getWriter();
		out.println("<script>alert(\"입력정보를 다시한번 확인해주세요\"); location.href='/board/lregister'</script>");
		out.flush();
		return "";
		}
		}catch(Exception e) {
			res.setContentType("text/html; charset=euc-kr");
			PrintWriter out = res.getWriter();
			out.println("<script>alert(\"입력정보를 다시한번 확인해주세요\"); location.href='/board/lregister'</script>");
			out.flush();
			return "";
		}
	}
	@GetMapping("/lregister")
	public void lregister() {
		
	}
	//web login page
	@GetMapping("/login")
	public String login() {
		return "board/login";
	}
	//login check
	@RequestMapping("/logincheck")
	public ModelAndView loginCheck(@ModelAttribute MemberVO member, HttpSession session){
			boolean result = service.loginCheck(member, session);
			ModelAndView mav = new ModelAndView();
			service.viewMember(member.getIdinfo());
			if(result == true) {
				MemberVO member1 = service.viewMember(member.getIdinfo());
				int uno = member1.getUno().intValue();
				session.setAttribute("uno", new Integer(uno));
				session.setAttribute("idinfo", member.getIdinfo());
				session.setAttribute("passwd", member.getPasswd());
				mav.setViewName("redirect:/board/list");
			}else {
				mav.setViewName("/board/login");
				mav.addObject("msg","failure");
			}
			return mav;
	}
	//log out
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		service.logout(session);
		return "redirect:/board/list";
	}
	//comment delete
	@PostMapping("/cdel")
	public String cDelete(CommentVO comment) {
		service.cDelete(comment.getCno());
		return "redirect:/board/get?bno="+comment.getBno();
	}
	//comment insert
	@PostMapping("/cinsert")
	public String cinsert(CommentVO comment) {
		service.cInsert(comment);
		
		return "redirect:/board/get?bno="+comment.getBno();
	}
	@GetMapping("/cinsert")
	public void cinsert() {
		
	}
}
