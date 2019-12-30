package com.cjit.ws.dao;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.cjit.vms.input.model.CommonCode;
import com.cjit.ws.entity.VmsTransInfo;

public class VmsTransInfoDaoImpl  extends SqlMapClientDaoSupport  implements VmsTransInfoDao{

	@Override
	public String insert(VmsTransInfo vmsTransInfo) {
		try{
			getSqlMapClientTemplate().insert("insertVmsTransInfo",vmsTransInfo);
		}catch(Exception e){
			return "��������ʧ��,���鱨���Ƿ���ȷ���Ժ����ԣ�";
		}
		return "Y";
	}

	@Override
	public String find(Map map) {
		List list =  getSqlMapClientTemplate().queryForList("selectCommonCode", map);

		if (list != null && list.size() > 0){
			CommonCode commonCode = (CommonCode) list.get(0);
			return commonCode.getName();

		}
		return null;
	}
}
