module EvaluationsHelper
  # Good数を返す
  def get_good_count( image_id )
    Evaluation.where(image_id: image_id, evaluation: Evaluation::GOOD).count()
  end

  # Bad数を返す
  def get_bad_count( image_id )
    Evaluation.where(image_id: image_id, evaluation: Evaluation::BAD).count()
  end
end
