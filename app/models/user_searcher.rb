class UserSearcher
  include ActiveModel::Serialization
  attr_reader :users, :search_params

  def initialize(params)
    @search_params = User.column_names.each_with_object({}) do |column_name, hash|
      hash[column_name] = params[column_name]
    end.compact
    validate_search_format
  end

  def search
    execute_search
  end

  OPERATION_MAPPER = {
    'gte': '>=',
    'lte': '<=',
    'gt': '>',
    'lt': '<',
    'is': '=',
    'not': '<>',
    'in': 'IN',
    'like': 'LIKE',
  }.with_indifferent_access

  private

  def validate_search_format
    # TODO: figure out why this exception is coming as undefined constant
    # raise ApiExceptions::SearchFormatError unless valid_search_format?
  end

  def valid_search_format?
    search_params.values.all? do |conditions|
      conditions.is_a?(Array) && conditions.all? do |condition|
        condition.is_a?(Hash) && valid_keys?(condition)
      end
    end
  end

  def valid_keys?(condition)
    (condition.keys & OPERATION_MAPPER.keys.map(&:to_s)).size == condition.keys.size
  end

  def execute_search
    query = User
    search_params.each do |field, operations|
      operations.each do |comp, value|
        # TODO: figure out why iterating through rails params is so weird
        query = query.where("#{field} #{map_comp(comp)} ?", map_value(value))
      end
    end
    query
  end

  def map_comp(comp)
    OPERATION_MAPPER[comp]
  end

  def map_value(value)
    return value unless value.is_a?(Array)
    "(#{value.join(', ')})"
  end
end
