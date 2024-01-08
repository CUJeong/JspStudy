package com.study.jsp.commons;

public class Search {
	private String keyword;
	private String searchOption;
	
	public Search() {}
	
	public Search(String keyWord, String searchOption) {
		this.keyword = keyWord;
		this.searchOption = searchOption;
	}

	@Override
	public String toString() {
		return "Search [keyWord=" + keyword + ", searchOption=" + searchOption + "]";
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyWord) {
		this.keyword = keyWord;
	}

	public String getSearchOption() {
		return searchOption;
	}

	public void setSearchOption(String searchOption) {
		this.searchOption = searchOption;
	}
	
}
