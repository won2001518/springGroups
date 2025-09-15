package com.spring.springGroupS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springGroupS.service.AdminService;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
		
	@GetMapping("/adminMain")
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@GetMapping("/adminLeft")
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	
	@GetMapping("/adminContent")
	public String adminContentGet() {
		return "admin/adminContent";
	}
	
	@GetMapping("/member/adMemberList")
	public String adMemberListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="level", defaultValue = "99", required = false) int level
		) {
		// 페이징 처리하기
		
		List<MemberVO> vos = memberService.getMemberList(0, pageSize, level);
		
		// 페이징처리 변수 넘겨주기
		
		model.addAttribute("vos", vos);
		model.addAttribute("level", level);
		return "admin/member/adMemberList";
	}
}
