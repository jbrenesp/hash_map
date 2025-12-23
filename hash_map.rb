class HashMap
  attr_reader :capacity
  
  def initialize
    @load_factor = 0.75
    @capacity = 16
    @buckets = Array.new(@capacity) { [] }
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

    bucket.each  do |pair| 
      if pair[0] == key
        pair[1] = value
        found = true
      end
    end
    unless found
      bucket << [key,value]
    end
    
    if length > (@capacity * @load_factor)
        resize
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

  def remove(key)
    hash_code = hash(key)
    bucket_index = hash_code % @capacity
    bucket = @buckets[bucket_index]
   
    
    bucket.each_with_index do |pair, index|
      if pair[0] == key
        removed_value = pair [1]
        bucket.delete_at(index)
        return removed_value
      end
    end
    nil
  end

  def length
    counter = 0
    @buckets.each do |bucket|
      number_of_pairs = bucket.length
        counter += number_of_pairs
    end
    return counter
  end

  def clear
    @buckets.each do |bucket|
      bucket.clear
    end
  end

  def keys
    all_keys = []
    @buckets.each do |bucket|
      bucket.each do |pair|
        all_keys << pair[0]
      end
    end
    return all_keys
  end

  def values
    all_values = []
    @buckets.each do |bucket|
      bucket.each do |pair|
        all_values << pair[1]
      end
    end
    return all_values
  end

  def entries
    all_pairs = []
    @buckets.each do |bucket|
      bucket.each do |pair|
        all_pairs << pair
      end
    end
    return all_pairs
  end

  def resize
  old_buckets = @buckets
  @capacity *= 2
  @buckets = Array.new(@capacity) { [] }

  old_buckets.each do |bucket|
    bucket.each do |key, value|
      set(key, value)
    end
  end
end


end
