require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + '/life')

class LifeTest < Test::Unit::TestCase
  def setup
    @empty_universe = Universe.new
    @universe_with_one_life_form = Universe.new([[1,1]])
  end

  def test_can_create_universe
    assert_not_nil @empty_universe
  end

  def test_can_add_life_to_the_universe
    assert_equal @universe_with_one_life_form.life, [[1,1]]
  end

  def test_new_universe_has_no_life
    assert_empty @empty_universe.life
  end

  def test_evolving_a_universe_with_one_life_form_results_in_no_life
    universe = @universe_with_one_life_form.evolve
    assert_empty universe.life
  end

  def test_evolving_a_row_of_three
    universe = Universe.new([[0,0], [0,1], [0, 2]])
    universe2 = universe.evolve
    assert universe2.life.include? [1,1]
  end

  def test_flipper
    universe = Universe.new([[0,0], [0,1], [0, 2]])
    [[-1,1], [0,1], [1,1]].each do |cell|
      assert universe.evolve.life.include? cell
    end
  end

  def test_glider
    glider = [[0, 1], [1, 2], [2, 0], [2, 1], [2, 2]]
    glider2 = [[1, 0], [1, 2], [2, 1], [2, 2], [3, 1]]
    universe = Universe.new glider
    universe2 = universe.evolve
    glider2.each do |cell|
      assert universe2.life.include? cell
    end
  end

end
