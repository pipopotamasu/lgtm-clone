module EvaluationsHelper
  # Good数を返す
  def get_good_count(image_id)
    Evaluation.where(image_id: image_id, evaluation: Evaluation::GOOD).count
  end

  # Bad数を返す
  def get_bad_count(image_id)
    Evaluation.where(image_id: image_id, evaluation: Evaluation::BAD).count
  end

  # 現在のログインユーザがすでに画像に評価をつけているかどうか?
  def current_user_already_evaluated?(user_id, image_id)
    Evaluation.where(user_id: user_id, image_id: image_id).exists?
  end

  # 現在のログインユーザがgoodに評価をつけているかどうか
  def current_user_evaluated_as_good?(user_id, image_id)
    Evaluation.exists?(user_id: user_id, image_id: image_id, evaluation: Evaluation::GOOD)
  end
end
