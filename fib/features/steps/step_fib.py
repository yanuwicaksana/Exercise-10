import fibonacci
from behave import given, when, then

@given(u'a count of "{count}"')
def step_impl(context, count):
    context.count = int(count)

@when(u'I call the fib function')
def step_impl(context):
	try:
		context.result = fibonacci.fib(context.count)
	except Exception as e:
		context.error = e

@then(u'it should return a sequence "{sequence}"')
def step_impl(context, sequence):
    expected_seq = [int(s) for s in sequence.split(",")]
    assert expected_seq == context.result

@then(u'it should return an empty sequence')
def step_impl(context):
    assert context.result == []

@given(u'a non-integer count of "foobar"')
def step_impl(context):
    context.count = 'foobar'

@then(u'it should throw a TypeError exception')
def step_impl(context):
	assert isinstance(context.error, TypeError)


    