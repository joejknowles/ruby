require 'test/unit'

class TestSprintf < Test::Unit::TestCase
  def test_positional
    assert_equal("     00001", sprintf("%*1$.*2$3$d", 10, 5, 1))
  end

  def test_binary
    assert_equal("0", sprintf("%b", 0))
    assert_equal("1", sprintf("%b", 1))
    assert_equal("10", sprintf("%b", 2))
    assert_equal("..1", sprintf("%b", -1))

    assert_equal("   0", sprintf("%4b", 0))
    assert_equal("   1", sprintf("%4b", 1))
    assert_equal("  10", sprintf("%4b", 2))
    assert_equal(" ..1", sprintf("%4b", -1))

    assert_equal("0000", sprintf("%04b", 0))
    assert_equal("0001", sprintf("%04b", 1))
    assert_equal("0010", sprintf("%04b", 2))
    assert_equal("1111", sprintf("%04b", -1))

    assert_equal("0000", sprintf("%.4b", 0))
    assert_equal("0001", sprintf("%.4b", 1))
    assert_equal("0010", sprintf("%.4b", 2))
    assert_equal("1111", sprintf("%.4b", -1))

    assert_equal("  0000", sprintf("%6.4b", 0))
    assert_equal("  0001", sprintf("%6.4b", 1))
    assert_equal("  0010", sprintf("%6.4b", 2))
    assert_equal("  1111", sprintf("%6.4b", -1))

    assert_equal(" 0b0", sprintf("%#4b", 0))
    assert_equal(" 0b1", sprintf("%#4b", 1))
    assert_equal("0b10", sprintf("%#4b", 2))
    assert_equal("0b..1", sprintf("%#4b", -1))

    assert_equal("0b00", sprintf("%#04b", 0))
    assert_equal("0b01", sprintf("%#04b", 1))
    assert_equal("0b10", sprintf("%#04b", 2))
    assert_equal("0b11", sprintf("%#04b", -1))

    assert_equal("0b0000", sprintf("%#.4b", 0))
    assert_equal("0b0001", sprintf("%#.4b", 1))
    assert_equal("0b0010", sprintf("%#.4b", 2))
    assert_equal("0b1111", sprintf("%#.4b", -1))

    assert_equal("0b0000", sprintf("%#6.4b", 0))
    assert_equal("0b0001", sprintf("%#6.4b", 1))
    assert_equal("0b0010", sprintf("%#6.4b", 2))
    assert_equal("0b1111", sprintf("%#6.4b", -1))

    assert_equal("+0", sprintf("%+b", 0))
    assert_equal("+1", sprintf("%+b", 1))
    assert_equal("+10", sprintf("%+b", 2))
    assert_equal("-1", sprintf("%+b", -1))

    assert_equal("  +0", sprintf("%+4b", 0))
    assert_equal("  +1", sprintf("%+4b", 1))
    assert_equal(" +10", sprintf("%+4b", 2))
    assert_equal("  -1", sprintf("%+4b", -1))

    assert_equal("+000", sprintf("%+04b", 0))
    assert_equal("+001", sprintf("%+04b", 1))
    assert_equal("+010", sprintf("%+04b", 2))
    assert_equal("-001", sprintf("%+04b", -1))

    assert_equal("+0000", sprintf("%+.4b", 0))
    assert_equal("+0001", sprintf("%+.4b", 1))
    assert_equal("+0010", sprintf("%+.4b", 2))
    assert_equal("-0001", sprintf("%+.4b", -1))

    assert_equal(" +0000", sprintf("%+6.4b", 0))
    assert_equal(" +0001", sprintf("%+6.4b", 1))
    assert_equal(" +0010", sprintf("%+6.4b", 2))
    assert_equal(" -0001", sprintf("%+6.4b", -1))
  end

  def test_nan
    nan = 0.0 / 0.0
    assert_equal("NaN", sprintf("%f", nan))
    assert_equal("NaN", sprintf("%-f", nan))
    assert_equal("+NaN", sprintf("%+f", nan))

    assert_equal("     NaN", sprintf("%8f", nan))
    assert_equal("NaN     ", sprintf("%-8f", nan))
    assert_equal("    +NaN", sprintf("%+8f", nan))

    assert_equal("00000NaN", sprintf("%08f", nan))
    assert_equal("NaN     ", sprintf("%-08f", nan))
    assert_equal("+0000NaN", sprintf("%+08f", nan))

    assert_equal("     NaN", sprintf("% 8f", nan))
    assert_equal(" NaN    ", sprintf("%- 8f", nan))
    assert_equal("    +NaN", sprintf("%+ 8f", nan))

    assert_equal(" 0000NaN", sprintf("% 08f", nan))
    assert_equal(" NaN    ", sprintf("%- 08f", nan))
    assert_equal("+0000NaN", sprintf("%+ 08f", nan))
  end

  def test_inf
    inf = 1.0 / 0.0
    assert_equal("Inf", sprintf("%f", inf))
    assert_equal("Inf", sprintf("%-f", inf))
    assert_equal("+Inf", sprintf("%+f", inf))

    assert_equal("     Inf", sprintf("%8f", inf))
    assert_equal("Inf     ", sprintf("%-8f", inf))
    assert_equal("    +Inf", sprintf("%+8f", inf))

    assert_equal("00000Inf", sprintf("%08f", inf))
    assert_equal("Inf     ", sprintf("%-08f", inf))
    assert_equal("+0000Inf", sprintf("%+08f", inf))

    assert_equal("     Inf", sprintf("% 8f", inf))
    assert_equal(" Inf    ", sprintf("%- 8f", inf))
    assert_equal("    +Inf", sprintf("%+ 8f", inf))

    assert_equal(" 0000Inf", sprintf("% 08f", inf))
    assert_equal(" Inf    ", sprintf("%- 08f", inf))
    assert_equal("+0000Inf", sprintf("%+ 08f", inf))

    assert_equal("-Inf", sprintf("%f", -inf))
    assert_equal("-Inf", sprintf("%-f", -inf))
    assert_equal("-Inf", sprintf("%+f", -inf))

    assert_equal("    -Inf", sprintf("%8f", -inf))
    assert_equal("-Inf    ", sprintf("%-8f", -inf))
    assert_equal("    -Inf", sprintf("%+8f", -inf))

    assert_equal("-0000Inf", sprintf("%08f", -inf))
    assert_equal("-Inf    ", sprintf("%-08f", -inf))
    assert_equal("-0000Inf", sprintf("%+08f", -inf))

    assert_equal("    -Inf", sprintf("% 8f", -inf))
    assert_equal("-Inf    ", sprintf("%- 8f", -inf))
    assert_equal("    -Inf", sprintf("%+ 8f", -inf))

    assert_equal("-0000Inf", sprintf("% 08f", -inf))
    assert_equal("-Inf    ", sprintf("%- 08f", -inf))
    assert_equal("-0000Inf", sprintf("%+ 08f", -inf))
    assert_equal('..f00000000',
      sprintf("%x", -2**32), '[ruby-dev:32351]')
    assert_equal("..101111111111111111111111111111111",
      sprintf("%b", -2147483649), '[ruby-dev:32365]')
  end

  def test_invalid
    # Star precision before star width:
    assert_raise(ArgumentError, "[ruby-core:11569]") {sprintf("%.**d", 5, 10, 1)}

    # Precision before flags and width:
    assert_raise(ArgumentError, "[ruby-core:11569]") {sprintf("%.5+05d", 5)}
    assert_raise(ArgumentError, "[ruby-core:11569]") {sprintf("%.5 5d", 5)}

    # Overriding a star width with a numeric one:
    assert_raise(ArgumentError, "[ruby-core:11569]") {sprintf("%*1s", 5, 1)}

    # Width before flags:
    assert_raise(ArgumentError, "[ruby-core:11569]") {sprintf("%5+0d", 1)}
    assert_raise(ArgumentError, "[ruby-core:11569]") {sprintf("%5 0d", 1)}

    # Specifying width multiple times:
    assert_raise(ArgumentError, "[ruby-core:11569]") {sprintf("%50+30+20+10+5d", 5)}
    assert_raise(ArgumentError, "[ruby-core:11569]") {sprintf("%50 30 20 10 5d", 5)}

    # Specifying the precision multiple times with negative star arguments:
    assert_raise(ArgumentError, "[ruby-core:11570]") {sprintf("%.*.*.*.*f", -1, -1, -1, 5, 1)}

    # Null bytes after percent signs are removed:
    assert_equal("%\0x hello", sprintf("%\0x hello"), "[ruby-core:11571]")

    assert_raise(ArgumentError, "[ruby-core:11573]") {sprintf("%.25555555555555555555555555555555555555s", "hello")}

    assert_raise(ArgumentError) { sprintf("%\1", 1) }
    assert_raise(ArgumentError) { sprintf("%!", 1) }
    assert_raise(ArgumentError) { sprintf("%1$1$d", 1) }
    assert_raise(ArgumentError) { sprintf("%0%") }
    assert_nothing_raised { sprintf("", 1) }
  end

  def test_float
    assert_equal("36893488147419111424",
                 sprintf("%20.0f", 36893488147419107329.0))
  end

  BSIZ = 120

  def test_skip
    assert_equal(" " * BSIZ + "1", sprintf(" " * BSIZ + "%d", 1))
  end

  def test_char
    assert_equal("a", sprintf("%c", 97))
    assert_equal("a", sprintf("%c", ?a))
    assert_raise(ArgumentError) { sprintf("%c", sprintf("%c%c", ?a, ?a)) }
    assert_equal(" " * (BSIZ - 1) + "a", sprintf(" " * (BSIZ - 1) + "%c", ?a))
    assert_equal(" " * (BSIZ - 1) + "a", sprintf(" " * (BSIZ - 1) + "%-1c", ?a))
    assert_equal(" " * BSIZ + "a", sprintf("%#{ BSIZ + 1 }c", ?a))
    assert_equal("a" + " " * BSIZ, sprintf("%-#{ BSIZ + 1 }c", ?a))
  end

  def test_string
    assert_equal("foo", sprintf("%s", "foo"))
    assert_equal("fo", sprintf("%.2s", "foo"))
    assert_equal(" " * BSIZ, sprintf("%s", " " * BSIZ))
    assert_equal(" " * (BSIZ - 1) + "foo", sprintf("%#{ BSIZ - 1 + 3 }s", "foo"))
    assert_equal(" " * BSIZ + "foo", sprintf("%#{ BSIZ + 3 }s", "foo"))
    assert_equal("foo" + " " * BSIZ, sprintf("%-#{ BSIZ + 3 }s", "foo"))
  end

  def test_integer
    assert_equal("01", sprintf("%#o", 1))
    assert_equal("0x1", sprintf("%#x", 1))
    assert_equal("0X1", sprintf("%#X", 1))
    assert_equal("0b1", sprintf("%#b", 1))
    assert_equal("0B1", sprintf("%#B", 1))
    assert_equal("1", sprintf("%d", 1.0))
    assert_equal("4294967296", sprintf("%d", (2**32).to_f))
    assert_equal("1", sprintf("%d", "1"))
    o = Object.new; def o.to_int; 1; end
    assert_equal("1", sprintf("%d", o))
    assert_equal("+1", sprintf("%+d", 1))
    assert_equal(" 1", sprintf("% d", 1))
    assert_equal("..f", sprintf("%x", -1))
    assert_equal("..7", sprintf("%o", -1))
    one = (2**32).coerce(1).first
    mone = (2**32).coerce(-1).first
    assert_equal("+1", sprintf("%+d", one))
    assert_equal(" 1", sprintf("% d", one))
    assert_equal("..f", sprintf("%x", mone))
    assert_equal("..7", sprintf("%o", mone))
    assert_equal(" " * BSIZ + "1", sprintf("%#{ BSIZ + 1 }d", one))
    assert_equal(" " * (BSIZ - 1) + "1", sprintf(" " * (BSIZ - 1) + "%d", 1))
  end

  def test_float2
    inf = 1.0 / 0.0
    assert_equal(" " * BSIZ + "Inf", sprintf("%#{ BSIZ + 3 }.1f", inf))
    assert_equal("+Inf", sprintf("%+-f", inf))
    assert_equal(" " * BSIZ + "1.0", sprintf("%#{ BSIZ + 3 }.1f", 1.0))
  end

  class T012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
  end

  def test_star
    assert_equal("-1 ", sprintf("%*d", -3, -1))
  end

  def test_escape
    assert_equal("%" * BSIZ, sprintf("%%" * BSIZ))
  end

  def test_rb_sprintf
    assert(T012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789.new.inspect =~ /^#<TestSprintf::T012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789:0x[0-9a-f]+>$/)
  end
end
