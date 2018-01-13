package com.foxtail.common.page;

public class PaginableFactroy {

	public static Pagination getPagination(Integer offset,Integer limit) {
		Pagination pagination = new Pagination();
		pagination.setPageSize(limit==null?-1:limit);
		pagination.setOffset(offset==null?-1:offset);;

		return pagination;
	}
	
}
