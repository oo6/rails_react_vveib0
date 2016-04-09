#!/usr/bin/env ruby

require 'qiniu'
Qiniu.establish_connection! :access_key => CONFIG['qiniu']['access_key'],
                            :secret_key => CONFIG['qiniu']['secret_key']
