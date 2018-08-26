require_relative "queue.rb"
require_relative "stack.rb"

class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    old_parent = @parent
    @parent = node #(1) sets the parent property and
    @parent.add_child(self) unless @parent == nil #(2) adds the node to
    old_parent.children.delete(self) unless old_parent == nil
    node.children << self unless node == nil || node.children.include?(self)
    @parent
  end

  def add_child(node)
    node.parent = self unless node.parent == self
  end

  def remove_child(node)
    if @children.include?(node)
      @children.select! { |child| child != node }
      node.parent = nil
    else
      raise "node is not a child"
    end
  end

# =>  uses stack or recursion. efficient memory usage.
# =>  not optimal algorithm. narrow-long
  def dfs(target_value, &prc)
    raise "need a target value or a proc" if [target_value, prc].none?
    prc ||= Proc.new { |node| node.value == target_value }
    return nil unless self
    return self if prc.call(self)

    self.children.each do |child|
      node = child.dfs(target_value, &prc)
      return node if node
    end
    nil
  end

# =>  uses queue(Queue is FIFO). inefficient memory usage.
# =>  optimal algorithm. wide-short
  def bfs(target_value, &prc)
    raise "need a target value or a proc" if [target_value, prc].none?
    prc ||= Proc.new { |node| node.value == target_value }
    return self if prc.call(self)

    nodes = Queue.new
    self.children.each { |child| nodes.enqueue(child) }
    until nodes.peek == nil
      node = nodes.dequeue
      return node if prc.call(node)
      node.children.each { |child| nodes.enqueue(child) }
    end
    nil
  end
end
