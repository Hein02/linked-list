# frozen_string_literal: true

# This class represents a linked list
#
# @!attribute [r] head
#   @return [Node] the first node of the linked list
#   @return [void] if empty
# @!attribute [r] tail
#   @return [Node] the last node of the linked list
#   @return [void] if empty
# @!attribute [r] size
#   @return [Number] total numbers of nodes in the linked list
class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  # Adds a new node containing value to the end of the list
  #
  # @param value value of any type
  # @return the newly created node
  def append(value)
    node = Node.new(value)
    @head = node if @head.nil?
    return @tail = node if @tail.nil?

    temp = @tail
    @tail = node
    temp.next = @tail
    @tail.prev = temp
    @size += 1
    node
  end

  # Adds a new node containing value to the start of the list
  #
  # @param value of any type
  # @return the newly created node
  def prepend(value)
    node = Node.new(value)
    @tail = node if @tail.nil?
    return @head = node if @head.nil?

    temp = @head
    @head = node
    temp.prev = @head
    @head.next = temp
    @size += 1
    node
  end

  # Returns the node at the given index
  #
  # @param index [Number] index of the node
  # @return [Node] the node at the given index
  def at(index, current_node = @head, count = 0)
    return current_node if index == count || current_node.nil?

    count += 1
    at(index, current_node.next, count)
  end

  # Removes the last element from the list
  #
  # @return [Node] the node being removed
  def pop
    node = @tail
    @tail.prev.next = nil
    @tail = @tail.prev
    node
  end

  # Returns true if the passed in value is in the list and otherwise returns false
  #
  # @param value of any type
  # @return [true] if the passed in value is in the list
  # @return [false] if the passed in value is not in the list
  def contains?(value, current_node = @head)
    return false if current_node.nil?
    return true if value == current_node.value

    contains?(value, current_node.next)
  end

  # Returns the index of the node containing value, or nil if not found
  #
  # @param value of any type
  # @return [Number] if the value is found
  # @return [void] if not found
  def find(value, current_node = @head, count = 0)
    return if current_node.nil?
    return count if value == current_node.value

    count += 1
    find(value, current_node.next, count)
  end

  # Inserts a new node with the provided value at the given index
  #
  # @param value of any type
  # @param index [Number] the index to insert the node
  # @return [Node] newly created node
  def insert_at(value, index)
    new_node = Node.new(value)
    current_node = at(index)
    return prepend(value) if current_node == @head
    return append(value) if current_node == @tail || current_node.nil?

    new_node.prev = current_node.prev
    new_node.next = current_node
    current_node.prev.next = new_node
    new_node
  end

  # Removes the node at the given index
  #
  # @param index [Number] the index of the node to be removed
  # @return [void] if the node is not found
  # @return [Node] the node being removed
  def remove_at(index)
    current_node = at(index)
    return if current_node.nil?
    return pop if current_node == @tail
    return shift if current_node == @head

    current_node.prev.next = current_node.next
    current_node
  end

  # Removes the head of the list
  #
  # @return [Node] the node being removed
  def shift
    node = @head
    @head = @head.next
    @head.prev = nil
    node
  end

  def to_s
    current_node = @head
    string = ''
    until current_node.nil?
      string += "( #{current_node.value} ) -> "
      current_node = current_node.next
    end
    "\nhead\n#{@head}\ntail\n#{@tail}\nlist: #{string} nil\n"
  end
end

# This class represents a node in the linked list
# @!attribute value
#   @return value of any types
#   @return [void] if empty
# @!attribute next
#   @return [Node] the node next to the caller node
#   @return [void] if empty
# @!attribute prev
#   @return [Node] the node prior to the caller node
#   @return [void] if empty
class Node
  attr_accessor :value, :next, :prev

  def initialize(value = nil)
    @value = value
    @next = nil
    @prev = nil
  end

  def to_s
    "\nvalue: #{@value}\nnext node value: #{@next&.value}\nprev node value: #{@prev&.value}\n"
  end
end
