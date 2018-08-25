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

  def dfs(target_value)

  end

  def bfs(target_value)

  end
end
