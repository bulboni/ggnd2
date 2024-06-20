# Use a specific version of the base image for stability
FROM ubuntu:20.04

# Set non-interactive mode for the build process
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    wget gcc ufw sudo tmate curl openssh-server

# Create and switch to the application directory
WORKDIR /myapp


# Setup SSH and tmate
RUN mkdir /run/sshd && \
    echo "tmate -F &" >> /openssh.sh && \
    echo "sleep 5" >> /openssh.sh && \
    echo "sudo ufw enable" >> /openssh.sh && \
    echo "sudo ufw allow 443" >> /openssh.sh && \
    echo '/usr/sbin/sshd -D' >> /openssh.sh && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'root:147' | chpasswd && \
    chmod 755 /openssh.sh

# Expose necessary ports
EXPOSE 80 443 3306 4040 5432 5700 5701 5010 6800 6900 8080 8888 9000

# Define the entrypoint script to run
CMD /openssh.sh
