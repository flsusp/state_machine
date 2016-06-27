#!/usr/bin/env ruby

require 'ruby-graphviz'
require_relative 'src/state_machine'
require_relative 'spec/sample_state_machine'

nodes, edges = SampleStateMachine.graph

g = GraphViz.new( :G, :type => :digraph )

gnodes = {}
nodes.each { |node| gnodes[node] = g.add_nodes(node.to_s) }
edges.each do |edge|
  from = gnodes[edge[:from]]
  to = gnodes[edge[:to]]
  g.add_edges(from, to, label: edge[:label])
end
g.output(png: ARGV[0])
