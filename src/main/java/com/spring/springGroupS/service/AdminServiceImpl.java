package com.spring.springGroupS.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	AdminDAO adminDAO;

	@Override
	public int setMemberLevelChange(int idx, int level) {
		return adminDAO.setMemberLevelChange(idx, level);
	}

	@Override
	public int setMemberLevelSelectChange(String idxSelectArray, int levelSelect) {
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		int res = 0;
		for(String idx : idxSelectArrays) {
			res = adminDAO.setMemberLevelChange(Integer.parseInt(idx), levelSelect);
		}
		
		return res;
	}
	
}
