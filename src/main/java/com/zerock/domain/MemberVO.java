package com.zerock.domain;

import lombok.Data;
//member
@Data
public class MemberVO {
	private Long uno;
	private String idinfo;
	private String passwd;
	private String passwdc;
	@Override
	public String toString() {
		return "MemberVO [uno="+uno+",idinfo="+idinfo+", passwd="+passwd+"]";
	}
}
