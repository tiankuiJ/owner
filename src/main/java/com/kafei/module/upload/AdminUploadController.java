package com.kafei.module.upload;

import com.alibaba.fastjson.JSONObject;
import com.kafei.util.PropsConfig;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("upload")
public class AdminUploadController {
	@RequestMapping("upload")
	@ResponseBody
	public Object upload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String rootPath = PropsConfig.getPropValue("pic_real_path");
		String savePath = "";
		if (rootPath.endsWith("/"))
			savePath = rootPath;
		else
			savePath = rootPath.concat("/");
		String randomStr = DateFormatUtils.format(new Date(), "yyyy/MM/dd");
		if (StringUtils.isBlank(savePath))
			savePath = request.getSession().getServletContext()
					.getRealPath("/");
		savePath = savePath.concat("/").concat(randomStr);
		File fi = new File(savePath);
		if (!fi.exists()) {
			fi.mkdirs();
		}
		// 绝对路径
		String uploadPath = request.getScheme() + "://"
				+ request.getServerName() + ":" + request.getServerPort();
		DiskFileItemFactory fac = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(fac);
		upload.setHeaderEncoding("utf-8");
		List fileList = null;
		String resultPath = "";
		JSONObject obj = new JSONObject();
		try {
			fileList = upload.parseRequest(request);
			Iterator<FileItem> it = fileList.iterator();
			String name = "";
			String extName = "";
			String filePath = "";
			while (it.hasNext()) {
				FileItem item = it.next();
				if (!item.isFormField()) {
					name = item.getName();
					if (name == null || name.trim().equals("")) {
						continue;
					}
					if (name.lastIndexOf(".") >= 0) {
						File file = null;
						do {
							name=System.currentTimeMillis()+name.substring(name.lastIndexOf(".",name.length()));
							file = new File(savePath.concat("/").concat(name));
						} while (file.exists());
						File saveFile = new File(savePath.concat("/").concat(
								name));
						item.write(saveFile);
						filePath = uploadPath.concat("/upload/")
								.concat(randomStr).concat("/").concat(name);
						resultPath = resultPath.concat(filePath).concat(",");
					}
				}
			}
			obj.put("error", 0);
			// 返回绝对路径
			if (resultPath.endsWith(",")) {
				resultPath = resultPath.substring(0, resultPath.length() - 1);
			}
			obj.put("url", resultPath);
		} catch (Exception e) {
			obj.put("error", 1);
			obj.put("message", "上传失败");
			e.printStackTrace();
		}
		return obj;
	}
}
