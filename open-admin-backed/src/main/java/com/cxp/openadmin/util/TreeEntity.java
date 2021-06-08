package com.cxp.openadmin.util;

import java.util.List;

public interface TreeEntity<E> {

    Integer getId();

    Integer getParentId();

    void setChildren(List<E> children);
}
