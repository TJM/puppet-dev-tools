FROM debian:stretch-slim

# Set up the paths for Software Collection Library tools
# ENV PATH=/opt/rh/rh-ruby24/root/usr/local/bin:/opt/rh/rh-ruby24/root/usr/bin:/opt/rh/rh-git218/root/usr/local/bin:/opt/rh/rh-git218/root/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# ENV LD_LIBRARY_PATH=/opt/rh/rh-ruby24/root/usr/local/lib64:/opt/rh/rh-ruby24/root/usr/lib64:/opt/rh/rh-git218/root/usr/local/lib64:/opt/rh/rh-git218/root/usr/lib64
# ENV MANPATH=/opt/rh/rh-ruby24/root/usr/local/share/man:/opt/rh/rh-ruby24/root/usr/share/man:/opt/rh/rh-git218/root/usr/local/share/man:/opt/rh/rh-git218/root/usr/share/man
# ENV X_SCLS=rh-ruby24,rh-git218
# ENV XDG_DATA_DIRS=/opt/rh/rh-ruby24/root/usr/local/share:/opt/rh/rh-ruby24/root/usr/share:/opt/rh/rh-git218/root/usr/local/share:/opt/rh/rh-git218/root/usr/share:/usr/local/share:/usr/share
# ENV PKG_CONFIG_PATH=/opt/rh/rh-ruby24/root/usr/local/lib64/pkgconfig:/opt/rh/rh-ruby24/root/usr/lib64/pkgconfig:/opt/rh/rh-git218/root/usr/local/lib64/pkgconfig:/opt/rh/rh-git218/root/usr/lib64/pkgconfig

# Install latest PDK and image dependencies
RUN apt-get update && apt-get install -y curl && apt-get clean
RUN curl -JLO 'https://pm.puppet.com/cgi-bin/pdk_download.cgi?dist=debian&rel=9&arch=amd64&ver=latest' \
    && dpkg -i pdk_1.10.0.0-1stretch_amd64.deb \
    && rm -f pdk_1.10.0.0-1stretch_amd64.deb

#  \
#     && yum makecache && yum install -y \
#       make \
#       gcc \
#       gcc-c++ \
#       autoconf \
#       automake \
#       patch \
#       readline \
#       readline-dev \
#       zlib \
#       zlib-devel \
#       libffi-devel \
#       libxml2-devel \
#       openssl-devel \
#       libgcc \
#       bash \
#       wget \
#       ca-certificates

#Set up Ruby 2.4. Must be separate from Ruby installed with PDK
# RUN yum install -y centos-release-scl \
#     && yum-config-manager --enable rhel-server-rhscl-7-rpms \
#     && yum install -y rh-ruby24 rh-ruby24-ruby-devel rh-git218

# # Install dependent gems
# RUN gem install --no-ri --no-rdoc r10k \
#       json \
#       puppet:5.3.3 \
#       rubocop \
#       puppetlabs_spec_helper \
#       puppet-lint \
#       onceover \
#       rest-client \
#       ra10ke \
#     && ln -s /usr/local/bundle/bin/* /usr/local/bin/

COPY Rakefile /Rakefile

RUN mkdir -p /repo
WORKDIR /repo
