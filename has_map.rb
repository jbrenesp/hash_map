class HashMap
  def initialize
    @load_factor = 0.75
    @capacity = 16
  end

  def hash(key)
    hash_code = 0 
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
     hash_code
  end

  def set(key, value)
    hash_code = hash(key)
    bucket_index = hash_code % @capacity
    bucket = @buckets[bucket_index]

    found = false

    bucket.each  do |k, v| 
      if k == key
        v = value
        found = true
      end
    end
    if found == false
      bucket << [key,value]
    end
  end

  def get(key)
    hash_code = hash(key)
    bucket_index = hash_code % @capacity
    bucket = @buckets[bucket_index]
    
    bucket.each do |k, v|
      if k == key
        return v
      end
    end

    return nil
  end

  def has?(key)
    hash_code = hash(key)
    bucket_index = hash_code % @capacity
    bucket = @buckets[bucket_index]
    
    bucket.each do |k, v|
      if k == key
        return true
      end
    end

    return false
  end
