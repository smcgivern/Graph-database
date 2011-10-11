require 'erb'
require 'maruku'

def load(database)
  graphs = []

  open(database).each do |line|
    name, data = line.gsub('(', '|[').gsub(')', ']').split('|')
    data = eval(data)

    nodes = {}
    data[3].each_with_index {|c, i| nodes["#{i+1}"] = c.join(',')}

    graphs << {
      :name => name, :n => data[0], :m => data[1],
      :degrees => data[2].map {|x, y| [x] * y}.flatten,
      :nodes => nodes, :edges => data[4],
    }
  end

  graphs
end

def create_template(filename); ERB.new(open(filename).read); end

GRAPHS = load('database.gdb')
GRAPHVIZ = create_template('graph.dot.erb')
README = Maruku.new(open('README').read).to_html
INDEX = create_template('index.html.erb')
ABOUT = create_template('about.html.erb')
GRAPH_PAGE = create_template('graph.html.erb')

open('public/index.html', 'w').puts(INDEX.result)
open('public/about.html', 'w').puts(ABOUT.result)

GRAPHS.each do |graph|
  g = graph

  open("dot/#{g[:name]}.dot", 'w').
    puts(GRAPHVIZ.result(binding))

  open("public/#{g[:name]}.html", 'w').
    puts(GRAPH_PAGE.result(binding))
end
