package com.zerock.domain;

import java.util.Date;
import lombok.Data;
//board
@Data
public class BoardVO {
	private Long bno;
	private Long uno;
	private String title;
	private String content;
	private String writer;
	private String passwd;
	private Date regdate;
	private Date updatedate;
}
