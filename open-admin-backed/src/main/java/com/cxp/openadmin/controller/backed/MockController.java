package com.cxp.openadmin.controller.backed;

import com.cxp.openadmin.util.PagedGridResult;
import com.cxp.openadmin.util.HttpResponse;
import lombok.Data;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;
import java.util.stream.Stream;
import static java.util.stream.Collectors.toList;

@RestController
@RequestMapping("/backed/mock")
public class MockController {

    private List<String> names = Stream.of("短裤","风衣","运动鞋","T恤","七分裤").collect(toList());
    private List<Boolean> sends = Stream.of(true,false).collect(toList());

    @Data
    private class Good{
        private Date auditTime;
        private int id;
        private String name;
        private Date orderDate;
        private String orderId;
        private Boolean send;
        private Date sendTime;
        private int status;
    }

    @GetMapping("/goods")
    public HttpResponse goods(){
        PagedGridResult pagedGridResult = new PagedGridResult();

        List<Good> list = new ArrayList<>();

        for (int i = 1; i < 101; i++) {

            Random random = new Random();

            int status = (int)(1+Math.random()*(4-1+1));
            Good good = new Good();
            good.setAuditTime(new Date());
            good.setId(i);
            good.setName(names.get(random.nextInt(names.size())));
            good.setOrderDate(new Date());
            good.setSendTime(new Date());
            good.setStatus(status);
            good.setSend(sends.get(random.nextInt(sends.size())));
            good.setOrderId(UUID.randomUUID().toString());
            list.add(good);
        }

        pagedGridResult.setPage(1);
        pagedGridResult.setRows(list);
        pagedGridResult.setRecords(10);
        pagedGridResult.setTotal(100);
        return HttpResponse.success(pagedGridResult);
    }

}
