function diff_ab = usimole(fa, fb)
Ha = compute_infos(fa);
Hb = compute_infos(fb);
diff_ab = imabsdiff(Ha, Hb);