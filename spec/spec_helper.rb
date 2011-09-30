# encoding: utf-8
path = File.expand_path(File.dirname(__FILE__) + '/../lib/')
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)

require 'gaston'

def file_path( *paths )
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', *paths))
end
