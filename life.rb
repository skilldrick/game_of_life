class Universe
  def initialize cells=[]
    @cells = cells
  end

  def life
    @cells
  end

  def evolve
    neighbours_count = Hash.new 0
    @cells.each do |cell|
      row, column = cell
      ((row-1)..(row+1)).each do |r|
        ((column-1)..(column+1)).each do |c|
          neighbours_count[[r,c]] += 1 unless [r,c] == [row, column]
        end
      end
    end

    new_generation = []
    neighbours_count.each do |location, neighbour_count|
      state = @cells.include? location
      if get_new_state neighbour_count, state
        new_generation << location
      end
    end

    Universe.new new_generation
  end

  def get_new_state neighbour_count, current_state
    case neighbour_count
    when 0..1
      false
    when 2
      current_state
    when 3
      true
    when 4..8
      false
    end
  end
end
