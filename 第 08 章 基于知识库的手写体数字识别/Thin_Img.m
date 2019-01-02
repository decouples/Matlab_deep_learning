function I1 = Thin_Img(I)

I1 = bwmorph(I, 'thin', inf);