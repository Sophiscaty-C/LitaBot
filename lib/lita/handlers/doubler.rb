# -*- coding:utf-8 -*-
@operator=Array[2]
@operator[0]=%w[+ - * /]
@operator[1]=%w[( )]
@digit_reg=/(?:(?<=\D)-)?\d+(?:\.\d+)?/
@ope_reg=/ \+ | \- | \* | \/ | \( | \) /x
@ope_method={}
@ope_method["+"]=lambda{|x,y| x+y}
@ope_method["-"]=lambda{|x,y| x-y}
@ope_method["*"]=lambda{|x,y| x*y}
@ope_method["/"]=lambda{|x,y| x/y}
module Lita
  module Handlers
    class Doubler < Handler
      route(
	        /.*/i,
          :respond_answer,
	         command:true,
	         # help:{'None'}
          )
      def infix_to_suffix arr
        s1,s2=[],[] #stack
        arr.each do |x|
          if x =~/(?:(?<=\D)-)?\d+(?:\.\d+)?/ #数字处理
            s2.push format("%.2f",x).to_f
          else #非数字处理
            if %w[+ - * /].include? x # 运算符处理
              if s1.size==0 or
                s1[-1]==%w[( )][0] or
                (%w[+ - * /].index x) > (%w[+ - * /].index s1[-1]) then
                  s1.push x
                else
                    s2.push s1.pop
                    redo #可用于块
                end
              elsif %w[( )].include? x #括号处理
                if x==%w[( )][0]
                  s1.push x
                else
                  s2.push s1.pop until s1.size==0 || s1[-1]==%w[( )][0]
                  if s1.size==0
                    puts "error: bracket is not match\n"
                    exit
                  else
                    s1.pop
                  end
                end
              else
                puts "error: input symbol\n"
                exit
              end
            end
          end
        while s1.size !=0
          s2.push s1.pop
        end
        s2
      end

      def comput_suffix arr
        s_num=[] #also a stack
        arr.each do |x|
          if x.class == Float
            s_num.push x
          elsif s_num.size>=2
            a,b=s_num.pop,s_num.pop
            if x=="+"
              r=a+b
            elsif x=="-"
              r=b-a
            elsif x=="*"
              r=b*a
            elsif x=="/"
              r=b/a
            end
            puts "#{b} #{x} #{a} = #{r}"
            s_num.push r
          else
            break
          end
        end
        if s_num.size!=1
          puts "error: the equ is not true\n"
          exit
        end
        format("%.2f", s_num[0] ).to_f
      end

      def split_num_ope str
      #为了实现方便的输入
          outarr=[]
          #def不能传入local变量  *****
          define_singleton_method :handle_ope_str do |str|
              while(str=~/ \+ | \- | \* | \/ | \( | \) /x)
                  outarr.push $&
                  str=$'
              end
          end
          while(str=~/(?:(?<=\D)-)?\d+(?:\.\d+)?/)
              pre,now,nxt=$`,$&,$' #匹配 前中后,保存下来否则会改变
              handle_ope_str pre.strip unless pre.nil? or pre.strip==""
              outarr.push now
              str=nxt
              # puts pre+" / "+now+" / "+nxt
          end
          handle_ope_str str.strip unless str.nil? or str.strip==""
          p outarr
          outarr
      end

      def respond_answer(response)
        n=response.match_data
        instr=" "+n.to_s
        inarr=split_num_ope instr
        suf=infix_to_suffix inarr
        p comput_suffix suf
        response.reply "Finished!"
      end

      Lita.register_handler(self)
    end
  end
end
