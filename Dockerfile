FROM debian:testing

MAINTAINER <contato@eduardomedeiros.me>

# Add main repo
RUN echo 'deb http://ftp.nl.debian.org/debian/ stretch main contrib non-free' > /etc/apt/sources.list
ENV  DEBIAN_FRONTEND noninteractive

# Install devel packages
RUN apt-get -y update && apt-get install -y git vim procps wget make libxml2-dev curl g++ gcc zlib1g zlib1g-dev libtool libncurses5-dev libcurl4-nss-dev ruby2.3 ruby2.3-dev gem

# Install gem packages
RUN gem install puppet-lint bundle fpm

# Add support for ruby2 on puppet3.
RUN gem install puppet -v 3.8.7
ADD safe_yaml.rb /var/lib/gems/2.3.0/gems/puppet-3.8.7/lib/puppet/vendor/safe_yaml/lib/

# Add some aliases
ADD .bashrc /root/

# vim stuff.
# pathogen pathogen
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
ADD .vimrc /root/
# puppet-vim extension
RUN cd ~/.vim/bundle && git clone https://github.com/rodjek/vim-puppet.git
# tabular extension
RUN cd ~/.vim/bundle && git clone git://github.com/godlygeek/tabular.git
# syntastic extension
RUN cd ~/.vim/bundle  && git clone --depth=1 https://github.com/scrooloose/syntastic.git
