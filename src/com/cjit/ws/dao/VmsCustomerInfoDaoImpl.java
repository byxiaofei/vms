package com.cjit.ws.dao;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.cjit.ws.entity.VmsCustomerInfo;

public class VmsCustomerInfoDaoImpl  extends SqlMapClientDaoSupport implements VmsCustomerInfoDao{

	@Override
	public String insert(VmsCustomerInfo vmsCustomerInfo) {
		try{
			getSqlMapClientTemplate().insert("insertVmsCustomerInfo",vmsCustomerInfo);
		}catch(Exception e){
			return "��������ʧ��,���鱨���Ƿ���ȷ���Ժ����ԣ�";
		}
		return "Y";
	}

}
