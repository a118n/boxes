module ApplicationHelper

  def controller?(name)
    controller.controller_name == name
  end

  def action?(name)
    controller.action_name == name
  end

  def form_errors_for(object = nil)
    render('shared/form_errors', object: object) unless object.blank?
  end

  def table_for_supplies(object = nil)
    render('shared/table-supplies', object: object) unless object.blank?
  end

  def table_for_devices(object = nil)
    render('shared/table-devices', object: object) unless object.blank?
  end
end
