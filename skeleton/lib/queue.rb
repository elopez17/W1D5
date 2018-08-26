class Queue
  # Queue is FIFO.
  attr_reader :queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue.push(el)
    el
  end

  def dequeue
    @queue.shift
  end

  def peek
    @queue[0]
  end
end
