module LikesHelper
  def subject_path(subject)
    if subject.class.to_s == 'Micropost'
      return micropost_path(subject)
    else
      return micropost_path(subject.micropost)
    end
  end
end
