package edu.iot.lhp.bishe;

import edu.hust.iot.APIReturnFormat.*;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

@SpringBootApplication
@RestController
public class BisheApplication {

    private String command = "python3 inference.py --model /root/CGANTrained/pretrained/photo2pic.pb --input /root/CGANTrained/input_sample.jpg --output /root/CGANTrained/output_sample.jpg --image_size 256";
    private String result = "http://47.106.89.134:8080/result/output_sample.jpg";

    @Autowired
    private Environment env;

    @Autowired
    private DAO dao;

    @Value("${path.base}")
    private String basePath;

    @PostMapping("/login")
    public APIReturn login(String username, String password) {
        User user = dao.findOneByUsername(username);
        if (user == null || !user.getPassword().equals(password)) {
            return ErrorAPIReturn.build("登录失败！");
        } else {
            return OKAPIReturn.build("登录成功！");
        }
//        if (!username.equals(env.getProperty("login.username")) || !password.equals(env.getProperty("login.password"))) {
//            return ErrorAPIReturn.build("登录失败！");
//        }
//        return OKAPIReturn.build("登录成功！");
    }

    @PostMapping("/registration")
    public APIReturn registration(String username, String password) {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        dao.save(user);
        return OKAPIReturn.build("注册成功！");
    }

    @PostMapping("/upload")
    public APIReturn generateGANPicture(MultipartFile picture) {
        String filename = basePath + "/input_sample.jpg";
        try {
            File input = new File(filename);
            FileUtils.deleteQuietly(input);
            FileUtils.writeByteArrayToFile(input, picture.getBytes());
            Process process = Runtime.getRuntime().exec(command);
            process.waitFor();
            return DataAPIReturn.build("url", result);
        } catch (IOException e) {
            e.printStackTrace();
            return ErrorAPIReturn.build("IO异常：" + e.getMessage());
        } catch (InterruptedException e) {
            e.printStackTrace();
            return ErrorAPIReturn.build("等待异常：" + e.getMessage());
        }
    }

    public static void main(String[] args) {
        SpringApplication.run(BisheApplication.class, args);
    }
}
