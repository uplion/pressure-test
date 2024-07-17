# 使用 Ubuntu 作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装必要的依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    git \
    zlib1g-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 克隆 wrk 仓库
RUN git clone https://github.com/wg/wrk.git /wrk

# 编译并安装 wrk
WORKDIR /wrk
RUN make
RUN cp wrk /usr/local/bin

# 创建工作目录
WORKDIR /app

# 复制脚本文件到容器中
COPY wrk_process.lua /app/wrk_process.lua
COPY wrk_test /app/wrk_test

# 确保 wrk_test 是可执行的
RUN chmod +x /app/wrk_test

# 设置默认命令
CMD ["/app/wrk_test"]