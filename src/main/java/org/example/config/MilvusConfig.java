package org.example.config;

import io.milvus.client.MilvusServiceClient;
import io.milvus.param.ConnectParam;
import org.example.client.MilvusClientFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import jakarta.annotation.PreDestroy;
import java.util.concurrent.TimeUnit;

/**
 * Milvus 配置类
 * 负责创建和管理 MilvusServiceClient Bean
 */
@Configuration
public class MilvusConfig {

    private static final Logger logger = LoggerFactory.getLogger(MilvusConfig.class);

    @Autowired(required = false)
    private MilvusClientFactory milvusClientFactory;

    @Autowired
    private MilvusProperties milvusProperties;

    private MilvusServiceClient milvusClient;

    /**
     * 创建 MilvusServiceClient Bean
     * 
     * @return MilvusServiceClient 实例（可能为 null）
     */
    @Bean
    public MilvusServiceClient milvusServiceClient() {
        logger.info("正在初始化 Milvus 客户端...");
        
        // 尝试使用工厂创建客户端
        if (milvusClientFactory != null) {
            try {
                milvusClient = milvusClientFactory.createClient();
                logger.info("Milvus 客户端初始化完成");
                return milvusClient;
            } catch (Exception e) {
                logger.error("Milvus 客户端初始化失败: {}", e.getMessage());
            }
        }
        
        // 尝试直接创建客户端
        try {
            logger.info("尝试直接创建 Milvus 客户端...");
            ConnectParam connectParam = ConnectParam.newBuilder()
                    .withHost(milvusProperties.getHost())
                    .withPort(milvusProperties.getPort())
                    .withConnectTimeout(milvusProperties.getTimeout(), TimeUnit.MILLISECONDS)
                    .build();
            milvusClient = new MilvusServiceClient(connectParam);
            logger.info("Milvus 客户端直接创建成功");
            return milvusClient;
        } catch (Exception e) {
            logger.error("Milvus 客户端直接创建也失败: {}", e.getMessage());
            logger.warn("服务将在没有 Milvus 连接的情况下启动，向量搜索功能将不可用");
            return null;
        }
    }

    /**
     * 应用关闭时清理资源
     */
    @PreDestroy
    public void cleanup() {
        if (milvusClient != null) {
            logger.info("正在关闭 Milvus 客户端连接...");
            try {
                milvusClient.close();
                logger.info("Milvus 客户端连接已关闭");
            } catch (Exception e) {
                logger.warn("关闭 Milvus 客户端时出错: {}", e.getMessage());
            }
        }
    }
}
