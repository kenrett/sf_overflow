require 'spec_helper'

describe Vote do

  let (:user) { create(:user)}
  let (:question) { create(:question) }
  let (:vote) { create(:vote_question) }
  
  before do
    visit root_path
    fill_in('email', :with => user.email)
    fill_in('password', :with => user.password)
    click_button('Submit')
  end

  context "upvote on question" do
    it "should increase vote count" do
      visit question_path(question)
      expect {
        click_button('Upvote')
      }.to change{question.sum_votes}.from(0).to(1)
    end

    it "should increase vote count display" do
      visit question_path(question)
      click_button('Upvote')
      expect(find('.vote-count')).to have_content('1')
    end

    it "should not increase vote twice by same user" do
      visit question_path(question)
      click_button('Upvote')
      expect {
        click_button('Upvote')
      }.to_not change{question.sum_votes}.from(1).to(2)
    end
  end

  context "downvote on question" do
    it "should decrease vote count" do
      visit question_path(question)
      expect {
        click_button('Downvote')
      }.to change{question.sum_votes}.from(0).to(-1)
    end

    it "should decrease vote count display" do
      visit question_path(question)
      click_button('Downvote')
      expect(find('.vote-count')).to have_content('-1')
    end

    it "should not decrease vote twice by same user" do
      visit question_path(question)
      click_button('Downvote')
      expect {
        click_button('Downvote')
      }.to_not change{question.sum_votes}.from(-1).to(-2)
    end
  end

end
