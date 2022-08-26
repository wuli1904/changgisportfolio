package com.zerock.domain;

import lombok.Data;
//comment
@Data
public class CommentVO {
	private Long cno;
	private Long bno;
	private String writer;
	private String comnt;
}
