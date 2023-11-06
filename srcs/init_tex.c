/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   init_tex.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: doduwole <doduwole@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/10/06 16:15:35 by mamesser          #+#    #+#             */
/*   Updated: 2023/11/06 21:24:44 by doduwole         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/cub.h"

int	init_texture_dir(t_vars *vars, t_img *tex, int dir)
{
	tex->img = mlx_xpm_file_to_image(vars->mlx, vars->textures[dir],
			&tex->tex_w, &tex->tex_h);
	if (!tex->img)
		return (1);
	tex->addr = (int *)mlx_get_data_addr(tex->img, &tex->bpp,
			&tex->line_size, &tex->endian);
	if (!tex->addr)
		return (1);
	return (0);
}

int	init_wall_textures(t_vars *vars)
{
	vars->tex_h = 256;
	vars->tex_w = 256;
	if (init_texture_dir(vars, vars->tex_no, 0))
		return (1);
	if (init_texture_dir(vars, vars->tex_so, 1))
		return (1);
	if (init_texture_dir(vars, vars->tex_we, 2))
		return (1);
	if (init_texture_dir(vars, vars->tex_ea, 3))
		return (1);
	return (0);
}
