package com.cjit.vms.trans.model;

public class SelectOption {
	private String value;
	private String name;
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public SelectOption(String value, String name) {
		super();
		this.value = value;
		this.name = name;
	}
}
