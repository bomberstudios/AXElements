class TestAccessibilityErrors < MiniTest::Unit::TestCase

  def test_search_failure_shows_arguments
    e = Accessibility::SearchFailure.new(AX::DOCK, :list, {herp: :derp})
    assert_match /Could not find `list\(herp: :derp\)`/, e.message
    assert_match /as a child of AX::Application/, e.message
    assert_match /Element Path:\n\t\#<AX::Application/, e.message

    e = Accessibility::SearchFailure.new(AX::DOCK, :list, {})
    assert_match /Could not find `list`/, e.message

    e = Accessibility::SearchFailure.new(AX::DOCK, :list, nil)
    assert_match /Could not find `list`/, e.message
  end

  def test_search_failure_shows_element_path
    l = AX::DOCK.children.first
    e = Accessibility::SearchFailure.new(l, :trash_dock_item, nil)
    assert_match /AX::Application/, e.message
    assert_match /AX::List/, e.message
  end

end