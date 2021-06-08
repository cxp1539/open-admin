package com.cxp.openadmin.util;

import java.util.ArrayList;
import java.util.List;

public class TreeParser {
    /**
     * * 解析树形数据
     *
     * @param topId
     * @param entityList
     * @return
     */
    public static <E extends TreeEntity<E>> List<E> getTreeList(Integer topId, List<E> entityList) {
        List<E> resultList = new ArrayList<>();
        // 获取顶层元素集合
        Integer parentId;
        for (E entity : entityList) {
            parentId = entity.getParentId();
            if (parentId == null || topId == parentId) {
                resultList.add(entity);
            }
        }
        // 获取每个顶层元素的子数据集合
        for (E entity : resultList) {
            entity.setChildren(getSubList(entity.getId(), entityList));
        }
        return resultList;
    }

    /**
     * * 获取子数据集合
     *
     * @param id
     * @param entityList
     * @return
     */
    private static <E extends TreeEntity<E>> List<E> getSubList(Integer id, List<E> entityList) {
        List<E> childList = new ArrayList<>();
        Integer parentId;
        // 子集的直接子对象
        for (E entity : entityList) {
            parentId = entity.getParentId();
            if (id == parentId) {
                childList.add(entity);
            }
        }
        // 子集的间接子对象
        for (E entity : childList) {
            entity.setChildren(getSubList(entity.getId(), entityList));
        }
        // 递归退出条件
        if (childList.size() == 0) {
            return childList;
        }
        return childList;
    }
}
