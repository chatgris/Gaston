class Hash
  def deep_merge(other)
    m = proc {|_,o,n|
      if o.is_a?(Hash)
        o.merge(n,&m)
      else
        self[_] = n
      end
    }
    merge(other, &m)
  end
end
