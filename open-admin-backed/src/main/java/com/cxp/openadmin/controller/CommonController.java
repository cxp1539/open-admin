package com.cxp.openadmin.controller;

import com.cxp.openadmin.exception.http.UploadException;
import com.cxp.openadmin.util.HttpResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@RestController
@Slf4j
@RequestMapping("common")
public class CommonController {

    @Autowired
    private Environment env;

    @PostMapping("/upload")
    public HttpResponse upload(@RequestParam("file") MultipartFile file, String category){

        String fileSpace = env.getProperty("resource.upload-location");
        String fileServerUrl = env.getProperty("resource.server-url");
        String fileName = file.getOriginalFilename();
        String fileNameArr[] = fileName.split("\\.");
        String suffix = fileNameArr[fileNameArr.length - 1];
        String newFileName = UUID.randomUUID().toString() + "." + suffix;
        String finalFacePath = fileSpace + File.separator + category + File.separator + newFileName;
        File dist = new File(finalFacePath);
        if (dist.getParentFile() != null) {
            // 创建文件夹
            dist.getParentFile().mkdirs();
        }
        dist.setReadable(true);
        try {
            file.transferTo(dist);
        } catch (IOException e) {
            log.error("upload error {}",e.getMessage());
            throw new UploadException(1008);
        }
        return HttpResponse.success(fileServerUrl + '/' + category + '/' + newFileName);
    }

}
