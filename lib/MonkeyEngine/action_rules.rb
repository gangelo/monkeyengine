require 'time'
require 'singleton'

require 'MonkeyActions'
require 'MonkeyKeyboardEnUs'

# Handles monkey action rules.
class ActionRules
  include Singleton

# Retrieves tne next action for the monkey
#
# @param [monkey] the monkey whose next action is to be retrieved
# @return [MonkeyAction] the next monkey action
  def get_next_action(monkey)
    raise MonkeyEngine::Exceptions::InvalidOperationException.new \
        "The action [#{monkey.action.class.name}] for Monkey [#{monkey.monkey_symbol}] must be completed before calling get_next_action" \
          unless monkey.action.nil? || monkey.action.action_completed?

    # current_action = monkey.action

    # If the monkey is sleeping, or first action, wake him up.
    return MonkeyActionWake.new(monkey) if monkey.action.nil? || monkey.action.is_a?(MonkeyActionSleep)

    return get_next_action_eval(monkey) unless nil

    # Nothing else interesting, monkey takes a breather...
    # MonkeyActionPause.new(monkey, Random.new.rand(MonkeyActionPause::VALID_VALUES))
    MonkeyActionPause.new(monkey, 5)
  end

  def get_next_action_eval(monkey)
    keyboard_input = MonkeyEngine::MonkeyKeyboardEnUs.instance.get_keyboard_input

    return MonkeyActionType.new monkey, keyboard_input
  end

  # Evaluates an action and sets it to completed if the criteria for completion is met.
  def action_eval!(action)
    raise MonkeyEngine::Exceptions::NilArgumentException.new "The [action] to be evaluated cannot be nil" \
        if action.nil?

    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? Action

    action_eval_eat(action) if action.is_a?(MonkeyActionEat)
    action_eval_pause(action) if action.is_a?(MonkeyActionPause)
    action_eval_sleep(action) if action.is_a?(MonkeyActionSleep)
    action_eval_type(action) if action.is_a?(MonkeyActionType)
    action_eval_wake(action) if action.is_a?(MonkeyActionWake)

    # If we don't specifically handle the action, just let it pass through - Action#action_completed will
    # be set elsewhere.
    action.action_completed?
  end

  private

  # Action evaluation methods

  def action_eval_eat(action)
    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyActionEat

    action_eval_timed_action action
  end

  def action_eval_pause(action)
    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyActionPause

    action_eval_timed_action action
  end

  def action_eval_sleep(action)
    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyActionSleep

    action_eval_timed_action action
  end

  def action_eval_type(action)
    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyActionType

    # TODO: How do I evaluate this?

    action
  end

  def action_eval_wake(action)
    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyActionWake

    action.action_completed = true

    action
  end

  def action_eval_timed_action(action)
    raise MonkeyEngine::Exceptions::InvalidArgumentTypeException.new "The [action] is not the correct type" \
        unless action.is_a? MonkeyTimedAction

    action.action_completed = true if action.action_time_of_completion <= Time.now

    action
  end

end